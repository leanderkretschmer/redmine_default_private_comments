require 'redmine'
require 'redmine_default_private_comments/issue_patch'
require 'redmine_default_private_comments/journal_patch'

Redmine::Plugin.register :redmine_default_private_comments do
  name 'Redmine default private comments'
  author 'Intera GmbH'
  description 'This plugin makes comments private by default.'
  version '0.0.1'
  url 'https://github.com/Intera/redmine_default_private_comments'
end
