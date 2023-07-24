class Minions < ActiveRecord::Migration[7.0]
  def up
    create_table :minions do |t|
      t.references :thing
      10.times do |i|
        t.string "mcol#{i}"
      end
    end

    execute <<-END
      INSERT INTO minions(thing_id,
                          mcol0, mcol1, mcol2, mcol3, mcol4,
                          mcol5, mcol6, mcol7, mcol8, mcol9
                        )
      (
        SELECT things.id,
        rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
        rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
        rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
        rpad('x', 100, 'x')
        FROM things, generate_series(1, 10)
      );
    END
    # We get 10 minions for each thing in the DB
  end

  def down
    drop_table :minions
  end
end