From Windows:

1. Intall ipmiutils, http://ipmiutil.sourceforge.net/
2. cd  /cygdrive/c/Program Files (x86)/Sourceforge/ipmiutil
3. ./ipmiutil health -N $IP -U $USER -P $PASS
4. to restart: ./ipmiutil reset -c -w -x -N $IP -U $USER -P $PASS
5. to shutdown: ./ipmiutil reset -D -N $IP -U $USER -P $PASS
