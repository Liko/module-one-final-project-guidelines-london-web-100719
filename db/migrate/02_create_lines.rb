class CreateLines < ActiveRecord::Migration[5.2]

    def change
        create_table :lines do |t|
            t.string :name
            t.string :colour
        end
    end
end