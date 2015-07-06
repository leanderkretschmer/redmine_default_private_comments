module RedmineDefaultPrivateComments

  # Patches Redmine's Issue dynamically. Adds the method private_notes_or_default().
  module IssuePatch

    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods

      # Returns the value of the private_notes property of the current journal if there is one or "true" as default value.
      def private_notes_or_default
        if @current_journal
          @current_journal.private_notes
        else
          User.current.allowed_to?(:set_notes_private, project)
        end
      end

    end

  end
end

Issue.send(:include, RedmineDefaultPrivateComments::IssuePatch)