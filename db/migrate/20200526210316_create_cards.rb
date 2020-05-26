class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :responsable
      t.string :solicitante
      t.string :nombre
      t.string :descripcion
      t.string :lista
      t.date :fecha_solicitud
      t.date :fecha_cambio
      t.string :lista_anterior

      t.timestamps
    end
  end
end
