#!/usr/bin/env bb
;;
;; This script is intentded to be run after a new installation
;; It will set things up.

(defn nvm-post-install
  []
  (let [{:keys [exit err out]} 
        (shell/sh "bash" "-c" "source ~/.nvm/nvm.sh; nvm install --lts")]
    (if (zero? exit)
      (println out)
      (do (println "ERROR:" err)
          (System/exit 1)))))

(nvm-post-install)