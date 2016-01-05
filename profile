# /etc/profile
function noproxy
{
    unset http_proxy HTTP_PROXY https_proxy HTTPS_PROXY
    git config --global --unset http.proxy
    git config --global --unset https.proxy
}

function nokiaproxy
{
	http_proxy=http://10.144.1.10:8080
    HTTP_PROXY=$http_proxy
    https_proxy=$http_proxy
    HTTPS_PROXY=$https_proxy
    export http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
    git config --global http.proxy http://10.144.1.10:8080
    git config --global https.proxy http://10.144.1.10:8080
}
