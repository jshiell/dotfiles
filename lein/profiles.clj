{:user {:plugins [[venantius/ultra "0.1.9"]]
        :dependencies [[pjstadig/humane-test-output "0.6.0"]]
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]
        :ultra {:color-scheme :solarized_dark}}}
