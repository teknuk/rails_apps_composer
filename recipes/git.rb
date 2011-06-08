# Application template recipe for the rails_apps_composer. Check for a newer version here:
# https://github.com/RailsApps/rails_apps_composer/blob/master/recipes/git.rb

after_everything do
  
  say_wizard "Git recipe running 'after everything'"
  
  # Git should ignore some files
  remove_file '.gitignore'
  get "https://raw.github.com/RailsApps/rails3-application-templates/master/files/gitignore.txt", ".gitignore"

  if recipes.include? 'omniauth'
    append_file '.gitignore' do <<-TXT

# keep OmniAuth service provider secrets out of the Git repo
config/initializers/omniauth.rb
TXT
    end
  end

  # Initialize new Git repo
  git :init
  git :add => '.'
  git :commit => "-aqm 'new Rails app generated by Rails Apps Composer gem'"
  # Create a git branch
  git :checkout => ' -b working_branch'
  git :add => '.'
  git :commit => "-m 'Initial commit of working_branch'"
  git :checkout => 'master'
end

__END__

name: Git
description: "Set up Git and commit the initial repository."
author: RailsApps

exclusive: scm
category: other
tags: [scm]
