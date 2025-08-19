# lib/redmine_default_private_comments/patches.rb
require_relative 'issue_patch'
require_relative 'journal_patch'
require_relative 'labelled_form_builder_patch'

module RedmineDefaultPrivateComments
  module Patches
    def self.apply
      Issue.prepend IssuePatch if defined?(Issue)
      Journal.prepend JournalPatch if defined?(Journal)
      Redmine::Views::LabelledFormBuilder.prepend LabelledFormBuilderPatch
    end
  end
end
