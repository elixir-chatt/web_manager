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

Repo.insert!(%Photo{path: "https://example1.com", status: "pending", troll: false})
Repo.insert!(%Photo{path: "https://example2.com", status: "pending", troll: false})
Repo.insert!(%Photo{path: "https://example3.com", status: "accepted", troll: false})
Repo.insert!(%Photo{path: "https://example4.com", status: "accepted", troll: false})
Repo.insert!(%Photo{path: "https://example5.com", status: "accepted", troll: true})
Repo.insert!(%Photo{path: "https://example6.com", status: "accepted", troll: true})
Repo.insert!(%Photo{path: "https://example7.com", status: "accepted", troll: true})
Repo.insert!(%Photo{path: "https://example8.com", status: "rejected", troll: false})
Repo.insert!(%Photo{path: "https://example9.com", status: "rejected", troll: true})
