# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     WebManager.Repo.insert!(%WebManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias WebManager.Repo
alias WebManager.Photos.Photo

Repo.insert!(%Photo{path: "1.jpg", status: "pending", troll: false})
Repo.insert!(%Photo{path: "2.jpg", status: "pending", troll: false})
Repo.insert!(%Photo{path: "3.jpg", status: "accepted", troll: false})
Repo.insert!(%Photo{path: "4.jpg", status: "accepted", troll: false})
Repo.insert!(%Photo{path: "5.jpg", status: "accepted", troll: true})
