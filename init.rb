# plugins/redmine_default_private_comments/init.rb

require 'redmine'

module RedmineDefaultPrivateComments
  module LabelledFormBuilderPatch
    def check_box(field, options = {}, checked_value = "1", unchecked_value = "0")
      if @object_name.to_s == "issue" && field.to_s == "private_notes"
        options = options.symbolize_keys
        issue = @template.instance_variable_get(:@issue) rescue nil
        if issue && issue.respond_to?(:private_notes_or_default)
          options[:checked] = issue.private_notes_or_default
        end
      end
      super(field, options.except(:label), checked_value, unchecked_value)
    end
  end

  module IssuePatch
    def self.prepended(base)
      base.class_eval do
        after_initialize :set_private_notes_default
      end
    end

    def set_private_notes_default
      if new_record? && self.respond_to?(:user) && self.respond_to?(:project)
        self.private_notes = user.allowed_to?(:set_notes_private, project)
      end
      super if defined?(super)
    end

    def private_notes_or_default
      @current_journal&.private_notes || User.current.allowed_to?(:set_notes_private, project)
    end
  end

  module JournalPatch
    def private_notes_or_default
      @current_journal&.private_notes || User.current.allowed_to?(:set_notes_private, project)
    end
  end

  module Patches
    def self.apply
      Issue.prepend RedmineDefaultPrivateComments::IssuePatch if defined?(Issue)
      Journal.prepend RedmineDefaultPrivateComments::JournalPatch if defined?(Journal)
      Redmine::Views::LabelledFormBuilder.prepend RedmineDefaultPrivateComments::LabelledFormBuilderPatch
    end
  end
end

# Hook to apply patches after all plugins are loaded
class RedmineDefaultPrivateCommentsHook < Redmine::Hook::Listener
  def after_plugins_loaded(_context = {})
    RedmineDefaultPrivateComments::Patches.apply
  end
end

Redmine::Plugin.register :redmine_default_private_comments do
  name 'Redmine Default Private Comments'
  author 'Leander Kretschmer'
  description 'Aktiviert die Checkbox „Privater Kommentar“ standardmäßig, wenn der Nutzer berechtigt ist.'
  version '0.2.3'
  url 'https://github.com/leanderkretschmer/redmine_default_private_comments'
  author_url 'https://github.com/leanderkretschmer'
  requires_redmine version_or_higher: '6.0.0'
end
