# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PreloadTest.Repo.insert!(%PreloadTest.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias PreloadTest.{Post, PostTag, Comment, Repo, Tag}

Enum.each(0..5, fn i ->
  {:ok, post} = Post.changeset(%Post{}, %{name: "post-#{i}"}) |> Repo.insert()

  {:ok, comment} =
    Comment.changeset(%Comment{}, %{name: "comment-#{i}", post_id: post.id}) |> Repo.insert()

  {:ok, tag} = Tag.changeset(%Tag{}, %{tag: "tag-#{i}", comment_id: comment.id}) |> Repo.insert()

  {:ok, _post_tag} =
    PostTag.changeset(%PostTag{}, %{post_id: post.id, tag_id: tag.id}) |> Repo.insert()
end)
