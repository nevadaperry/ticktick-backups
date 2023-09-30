(ns ticktick-backups.core
  (:require [next.jdbc :as jdbc]
            [compojure.core :refer [defroutes GET POST context]]
            [compojure.route :as route]
            [org.httpkit.server :refer [run-server]]))

(defroutes ticktick-backups
  (GET "/" [] "Helloworld output"))

(defn -main []
  (run-server ticktick-backups {:port 5000})
  (let
   [datasource
    (next.jdbc/get-datasource
     {:dbtype (System/getenv "JDBC_DBTYPE")
      :host (System/getenv "JDBC_HOST")
      :dbname (System/getenv "JDBC_DBNAME")
      :user (System/getenv "JDBC_USER")
      :password (System/getenv "JDBC_PASSWORD")})]
    (println
     (jdbc/execute! datasource ["SELECT ? a, ? b" 4 5]))))
