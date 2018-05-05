defmodule PreloadTest.Tag do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tags" do
    field :tag, :string
    belongs_to :comment, PreloadTest.Comment

    field :post_id, :integer, virtual: true

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:tag, :comment_id])
    |> validate_required([:tag])
  end
end
