cd "$(dirname "${BASH_SOURCE[0]}")"

############################################################################
# A utility that can create certificates to enable the SPA to use HTTPS URLs
############################################################################

#
# Point to the OpenSSL configuration file for the platform
#
case "$(uname -s)" in

  # macOS
  Darwin)
    export OPENSSL_CONF='/System/Library/OpenSSL/openssl.cnf'
 	;;

  # Windows with Git Bash
  MINGW64*)
    export OPENSSL_CONF='C:/Program Files/Git/usr/ssl/openssl.cnf';
    export MSYS_NO_PATHCONV=1;
	;;

  # Linux
  Linux*)
    export OPENSSL_CONF='/usr/lib/ssl/openssl.cnf';
	;;
esac

ROOT_CERT_FILE_PREFIX='example.ca'
ROOT_CERT_DESCRIPTION='Development CA for Token Handler'
SSL_CERT_FILE_PREFIX='example.ssl'
SSL_CERT_PASSWORD='Password1'
WILDCARD_DOMAIN_NAME='*.example'


openssl genpkey -algorithm EC -pkeyopt ec_paramgen_curve:prime256v1 -out $ROOT_CERT_FILE_PREFIX.key
if [ $? -ne 0 ]; then
  echo '*** Problem encountered creating the Root CA key'
  exit 1
fi

openssl req \
    -x509 \
    -new \
    -key $ROOT_CERT_FILE_PREFIX.key \
    -out $ROOT_CERT_FILE_PREFIX.crt \
    -subj "/CN=$ROOT_CERT_DESCRIPTION" \
    -addext 'basicConstraints=critical,CA:TRUE' \
    -days 3650
if [ $? -ne 0 ]; then
  echo '*** Problem encountered creating the Root CA'
  exit 1
fi

openssl genpkey -algorithm EC -pkeyopt ec_paramgen_curve:prime256v1 -out $SSL_CERT_FILE_PREFIX.key
if [ $? -ne 0 ]; then
  echo '*** Problem encountered creating the SSL key'
  exit 1
fi

openssl req \
    -new \
    -key $SSL_CERT_FILE_PREFIX.key \
    -out $SSL_CERT_FILE_PREFIX.csr \
    -subj "/CN=$WILDCARD_DOMAIN_NAME" \
    -addext 'basicConstraints=critical,CA:FALSE'
if [ $? -ne 0 ]; then
  echo '*** Problem encountered creating the SSL certificate signing request'
  exit 1
fi

openssl x509 -req \
    -in $SSL_CERT_FILE_PREFIX.csr \
    -CA $ROOT_CERT_FILE_PREFIX.crt \
    -CAkey $ROOT_CERT_FILE_PREFIX.key \
    -out $SSL_CERT_FILE_PREFIX.crt \
    -days 365 \
    -extfile server.ext
if [ $? -ne 0 ]; then
  echo '*** Problem encountered creating the SSL certificate'
  exit 1
fi

rm 'example.ssl.csr'