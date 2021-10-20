export PATH=/Library/Java/JavaVirtualMachines/graalvm-ce-java11-21.2.0\ 2/Contents/Home/bin:$PATH
javac -d build src/com/hello/Graal.java
#java -cp ./build com.hello.Graal

jar cfvm Hello.jar manifest.txt -C build .
jar tf Hello.jar

java -jar Hello.jar

native-image -jar Hello.jar