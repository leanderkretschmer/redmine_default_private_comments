# lib/redmine_default_private_comments/issue_patch.rb
module RedmineDefaultPrivateComments
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
end
