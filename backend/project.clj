(defproject ticktick-backups "0.1.0"
  :dependencies [[org.clojure/clojure "1.11.1"]
                 [com.github.seancorfield/next.jdbc "1.2.659"]
                 [org.clojure/java.jdbc "0.4.2"]
                 [org.postgresql/postgresql "42.2.10"]
                 [compojure "1.7.0"]
                 [http-kit "2.3.0"]]
  :main ticktick-backups.core)
