class AddColumnMealtimeAndNotificationenabledToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mealtime_first, :time
    add_column :users, :line_notification_enabled, :boolean, default: false, null: false
  end
end
