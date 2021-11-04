class ChangeEvemtEntriesToEventEntries < ActiveRecord::Migration[5.2]
  def change
    rename_table :evemt_entries, :event_entries
  end
end
