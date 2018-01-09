[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile' 
# Setting PATH for Python 3.4
# The orginal version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH

if [[ `uname` == 'Darwin' ]]
then
  export JAVA_HOME=$(/usr/libexec/java_home)
fi


export PATH="$HOME/.cargo/bin:$PATH"
