#!/usr/bin/env bb
;;
;; This script is intentded to facilitate the installation of a new
;; system. I used to do this kind of thing in shell, but I don't like shell.
;; I'll experiment with this slowly, to check if it's a viable option.

(def nvm-script-url
  "https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh")

(defn nvm-download-script
  []
  (let [{:keys [exit err out]} (shell/sh "curl" "-o-" nvm-script-url)]
    (if (zero? exit)
      out
      (do (println "ERROR:" err)
          (System/exit 1)))))

(defn nvm-install
  []
  (let [nvm-script (nvm-download-script)
        {:keys [exit err out]} (shell/sh "bash" "-c" nvm-script)]
    (if (zero? exit)
      (println out)
      (do (println "ERROR:" err)
          (System/exit 1)))))

(nvm-install)