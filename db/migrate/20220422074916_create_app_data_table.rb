class CreateAppDataTable < ActiveRecord::Migration[6.1]
  def change
    # Add necessary columns to table as per your requirement
    create_table :app_data do |t|
      t.string :workspace_id
      t.string :gist_access_token

      t.timestamps
    end
  end
end
