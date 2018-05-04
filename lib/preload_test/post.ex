defmodule PreloadTest.Post do
  use Ecto.Schema
  import Ecto.Changeset


  schema "posts" do
    field :name, :string

    has_many :comments, PreloadTest.Comment
    many_to_many :post_tags, PreloadTest.Tag, join_through: "post_tags"
    has_many :comment_tags, through: [:comments, :tags]

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
