module RedmineDefaultPrivateComments

  # Patches Redmine's Journal dynamically.  Enables private_notes by default.
  module JournalPatch

    def self.included(base) # :nodoc:

      base.send(:include, InstanceMethods)

      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development
        after_initialize :set_private_notes_default_value
      end

    end

    module InstanceMethods

      # If the current user is allowed to create private notes, default value for private_notes is set to true.
      def set_private_notes_default_value
        if new_record?
          self.private_notes = user.allowed_to?(:set_notes_private, project)
        end
      end

    end

  end
end

Journal.send(:include, RedmineDefaultPrivateComments::JournalPatch)