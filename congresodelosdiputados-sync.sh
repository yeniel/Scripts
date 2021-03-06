#!/bin/sh

##### Constants

CURRENT_LEGISLATURA=12
DOWNLOADDIR=$TMPDIR/congreso
FAIL_SESION_RETRY=10

##### URLs

FIREBASE_URL=https://com-yeniellandestoy-congreso.firebaseio.com
LAST_UPLOADED_SESION_URL=lastUploadedSesion.json
CONGRESO_SESION_URL="https://app.congreso.es/votacionesWeb/OpenData?sesion=sesionIndex&completa=1&legislatura=$CURRENT_LEGISLATURA"

##### Config

rm -rf $DOWNLOADDIR
mkdir $DOWNLOADDIR

##### Functions

getXmlNodeValue() {
	echo $(xmllint --xpath "//$1/text()" $2 2>/dev/null)
}

PUT() {
	curl -s -X PUT -d "$1" "$FIREBASE_URL/$2" > /dev/null
}


##### Last Uploaded Sesion

lastUploadedSesionUrl=$FIREBASE_URL/$LAST_UPLOADED_SESION_URL

echo "\nGET Last Uploaded Sesión URL"
echo "$lastUploadedSesionUrl"

lastUploadedSesion=$(curl -s $lastUploadedSesionUrl)

echo "\nLast Sesión Uploaded: $lastUploadedSesion"

##### Download sesiones

sesionRetry=0

for index in {1..500}; do
	if [[ $sesionRetry -eq FAIL_SESION_RETRY ]]; then
		break
	fi

	sesionIndex=$(($lastUploadedSesion+$index))
	getSesionUrl=${CONGRESO_SESION_URL/sesionIndex/$sesionIndex}

	echo "\nGET Sesión zip file URL"
	echo $getSesionUrl 

	sesionZipFile=$DOWNLOADDIR/sesion$sesionIndex.zip

	curl -s --output $sesionZipFile "$getSesionUrl"

	sesionZipFileSize=$(wc -c $sesionZipFile | awk '{print $1}')

	if [[ $sesionZipFileSize -eq 0 ]]; then
		echo "Sesión doesn't exist in https://app.congreso.es"
		sesionRetry=$((sesionRetry+1))
	else
		echo "Sesión downloaded"
		unzip -q $sesionZipFile -d $DOWNLOADDIR
		lastDownloadedSesion=$sesionIndex
		sesionRetry=0
	fi

	rm -rf $sesionZipFile
done

##### Parse votaciones and upload to Firebase

if [ "$(ls -A $DOWNLOADDIR)" ]; then
	for votacionXml in $DOWNLOADDIR/*; do
		votacionLegislatura=$CURRENT_LEGISLATURA
		votacionSesion=$(getXmlNodeValue Sesion $votacionXml)
		votacionNumero=$(getXmlNodeValue NumeroVotacion $votacionXml)
		votacionFecha=$(getXmlNodeValue Fecha $votacionXml)
		votacionTitulo=$(getXmlNodeValue Titulo $votacionXml)
		votacionTextoExpediente=$(getXmlNodeValue TextoExpediente $votacionXml)
		votacionTituloSubGrupo=$(getXmlNodeValue TituloSubGrupo $votacionXml)
		votacionTextoSubGrupo=$(getXmlNodeValue TextoSubgrupo $votacionXml)
		votacionAsentimiento=$(getXmlNodeValue Asentimiento $votacionXml)
		votacionPresentes=$(getXmlNodeValue Presentes $votacionXml)
		votacionAFavor=$(getXmlNodeValue AFavor $votacionXml)
		votacionEnContra=$(getXmlNodeValue EnContra $votacionXml)
		votacionAbstenciones=$(getXmlNodeValue Abstenciones $votacionXml)
		votacionNoVotan=$(getXmlNodeValue NoVotan $votacionXml)

		votacionId="$CURRENT_LEGISLATURA-$(printf "%02d" $votacionSesion)-$(printf "%02d" $votacionNumero)"

		votacionJson="{\
			\"legislatura\": \"$votacionLegislatura\",\
			\"sesion\": \"$votacionSesion\",\
			\"numeroVotacion\": \"$votacionNumero\",\
			\"fecha\": \"$votacionFecha\",\
			\"titulo\": \"$votacionTitulo\",\
			\"textoExpediente\": \"$votacionTextoExpediente\",\
			\"tituloSubGrupo\": \"$votacionTituloSubGrupo\",\
			\"textoSubGrupo\": \"$votacionTextoSubGrupo\",\
			\"asentimiento\": \"$votacionAsentimiento\",\
			\"presentes\": \"$votacionPresentes\",\
			\"aFavor\": \"$votacionAFavor\",\
			\"enContra\": \"$votacionEnContra\",\
			\"abstenciones\": \"$votacionAbstenciones\",\
			\"noVotan\": \"$votacionNoVotan\"\
		}"

		echo "\nUploading to Firebase Votación $votacionId"

		PUT "$votacionJson" "votaciones/$votacionId.json"
	done
fi

##### Update Last Uploaded Session

if [[ ! -z "$lastDownloadedSesion" ]]; then
	echo "\nUpdate Last Uploaded Sesión to $lastDownloadedSesion"

	PUT $lastDownloadedSesion "$LAST_UPLOADED_SESION_URL"
fi

echo "\n"