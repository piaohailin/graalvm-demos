# Asynchronous Polyglot Programming in GraalVM Using Helidon and JavaScript

This is a polyglot Helidon HTTP web service that demonstrates how multiple JavaScript `Context`s can be executed in parallel to handle asynchronous operations with [Helidon](https://helidon.io/), mixing JavaScript `Promise` and Java `CompletableFuture` objects.

## Prerequisites
* [GraalVM](http://graalvm.org)

## Preparation

1. [Download GraalVM](https://www.graalvm.org/downloads/), unzip the archive, export the GraalVM home directory as the `$JAVA_HOME` and add `$JAVA_HOME/bin` to the `PATH` environment variable.

  On Linux:
  ```bash
  export JAVA_HOME=/home/${current_user}/path/to/graalvm
  export PATH=$JAVA_HOME/bin:$PATH
  ```
  On macOS:
  ```bash
  export JAVA_HOME=/Users/${current_user}/path/to/graalvm/Contents/Home
  export PATH=$JAVA_HOME/bin:$PATH
  ```
  On Windows:
  ```bash
  setx /M JAVA_HOME "C:\Progra~1\Java\<graalvm>"
  setx /M PATH "C:\Progra~1\Java\<graalvm>\bin;%PATH%"
  ```

2. Download or clone the repository and navigate into the `js-java-async-helidon` directory:
  ```bash
  git clone https://github.com/graalvm/graalvm-demos
  cd graalvm-demos/js-java-async-helidon
  ```

3. Build the application using Maven:
  ```bash
  mvn clean package
  ```

Now you are all set to run the polyglot Helidon Web service.

## Running the Application

You can run this Helidon HTTP web service with the following command:
```
$JAVA_HOME/bin/java -jar target/polyglotHelidonService-SNAPSHOT-jar-with-dependencies.jar
```

The application will create a new HTTP web service accepting requests on port `8080`.
Open [http://localhost:8080/greet?request=42](http://localhost:8080/greet?request=42) in the browser to send a request.

To demonstrate error handling, the application will not accept requests with `request` smaller than `42`.
For example, the following requests will return an error message:
```bash
curl http://localhost:8080/greet?request=41
curl http://localhost:8080/greet?request=foo
```

The Helidon HTTP server uses multiple Java threads.
Each thread runs a private JavaScript context.
To generate concurrent requests that will be handled by multiple threads, any workload generator can be used.
For example, using `wrk`:
```bash
wrk -c 100 -t 10 -d 100 http://localhost:8080/greet?request=42
```

## A Note About the Application

This is a sample application that, for brevity, contains reasonably large snippets of code inside the strings.
This is not the best approach for structuring polyglot apps, but the easiest to show in a compact way.
