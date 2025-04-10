#!/bin/bash


export DD_TRACE_AGENT_PORT=8136
quarkus build -DskipTests
java -javaagent:/Users/scott.gerring/dd-java-agent.jar \
  -Ddd.profiling.enabled=true \
  -XX:FlightRecorderOptions=stackdepth=256 \
  -Ddd.logs.injection=true \
  -Ddd.service=my-app \
  -Ddd.env=staging \
  -Ddd.version=1.0 \
  -Ddd.trace.integration.vertx.enabled=false \
  -Ddd.trace.executors=org.jboss.threads.EnhancedQueueExecutor \
  -jar target/quarkus-app/quarkus-run.jar
