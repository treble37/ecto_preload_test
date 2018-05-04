defmodule PreloadTest.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :tag, :string
      add :comment_id, references(:comments, on_delete: :nothing)

      timestamps()
    end

    create index(:tags, [:comment_id])
  end
end
