# lib/redmine_default_private_comments/journal_patch.rb
module RedmineDefaultPrivateComments
  module JournalPatch
    def private_notes_or_default
      unless RedmineDefaultPrivateComments.enabled_for_project?(project)
        return @current_journal&.private_notes
      end
      @current_journal&.private_notes || User.current.allowed_to?(:set_notes_private, project)
    end
  end
end
