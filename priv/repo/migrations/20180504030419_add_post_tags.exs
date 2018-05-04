defmodule PreloadTest.Repo.Migrations.AddPostTags do
  use Ecto.Migration

  def change do
    create table(:post_tags) do
      add :post_id, references(:posts)
      add :tag_id, references(:tags)
    end
  end
end
