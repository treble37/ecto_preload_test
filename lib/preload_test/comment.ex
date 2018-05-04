defmodule PreloadTest.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "comments" do
    field :name, :string
    has_many :tags, PreloadTest.Tag

    belongs_to :post, PreloadTest.Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:name, :post_id])
    |> validate_required([:name])
  end
end
