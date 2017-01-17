# /etc/profile
function noproxy
{
    unset http_proxy HTTP_PROXY https_proxy HTTPS_PROXY
    git config --global --unset-all http.proxy
    git config --global --unset-all https.proxy
}

function nokiaproxy
{
	http_proxy=http://10.144.1.10:8080
    HTTP_PROXY=$http_proxy
    https_proxy=$http_proxy
    HTTPS_PROXY=$https_proxy
    ftp_proxy=$http_proxy
    FTP_PROXY=$https_proxy
    export http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
    git config --global http.proxy http://10.144.1.10:8080
    git config --global https.proxy http://10.144.1.10:8080
}
export CCACHE_CPP2=yes

#[ -n "$XTERM_VERSION" ] && transset-df -a 0.90 >/dev/null
