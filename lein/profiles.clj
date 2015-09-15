{:user 
 {:plugins [[venantius/ultra "0.3.4"]] ; pimp your REPL - https://github.com/venantius/ultra
  :dependencies [[pjstadig/humane-test-output "0.7.0"] ; better test output - https://github.com/pjstadig/humane-test-output
                    [org.clojure/tools.namespace "0.2.11"]] ; namespace tools - https://github.com/clojure/tools.namespace
  :injections [(require 'pjstadig.humane-test-output)
                  (pjstadig.humane-test-output/activate!)
                  (require '(clojure.tools.namespace repl find))]
  :ultra {:color-scheme :solarized_dark}}}
