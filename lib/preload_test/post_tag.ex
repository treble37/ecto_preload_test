defmodule PreloadTest.PostTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post_tags" do
    belongs_to :post, PreloadTest.Post
    belongs_to :tag, PreloadTest.Tag
  end

  @doc false
  def changeset(post_tag, attrs) do
    post_tag
    |> cast(attrs, [:post_id, :tag_id])
    |> validate_required([:post_id, :tag_id])
  end
end
