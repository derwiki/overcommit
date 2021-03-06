module Overcommit::GitHook
  class JSSyntax < HookSpecificCheck
    include HookRegistry
    file_type :js

    JS_HINT_PATH        = Overcommit::Utils.script_path 'jshint.js'
    JS_HINT_RUNNER_PATH = Overcommit::Utils.script_path 'jshint_runner.js'

    def run_check
      return :warn, "Rhino is not installed" unless in_path? 'rhino'

      paths = staged.join(' ')

      output = `rhino -strict -f #{JS_HINT_PATH} #{JS_HINT_RUNNER_PATH} #{paths} 2>&1 | grep -v warning | grep -v -e '^js: '`
      return (output !~ /^ERROR/ ? :good : :bad), output
    end
  end
end
