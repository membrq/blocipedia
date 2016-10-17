class AddCollaboratorToWikis < ActiveRecord::Migration[5.0]
  def change
    add_column :wikis, :collaborator, :string
    add_column :wikis, :references, :string
  end
end
