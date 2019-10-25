# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    statuses = ConnectionStatus.create!([
      { name: "CHALLENGED", message:"Your account requires further verification! To authenticate your membership please go to 'resolve issues' and answer the challenges!" },
      { name: "CONNECTED" , message: nil},
      { name: "CREATED", message: "Please wait while we finish aggregating your account" },
      { name: "CLOSED", message: "Your membership has been marked as closed! If it becomes re-opened you may import the membership" },
      { name: "DEGRADED", message: "Your account has attempted to be imported too many times! Please try again later!" },
      { name: "DELAYED", message: "Importing your membership has taken longer than expected! Please check back later!"  },
      { name: "DENIED", message: "The credentials entered do not match your credentials at this institution. Please re-enter your credentials to continue importing data." },
      { name: "DISABLED", message: "Importing data from this institution has been disabled." },
      { name: "DISCONNECTED", message: "It looks like your data cannot be imported at this time"},
      { name: "DISCONTINUED", message: "Connections to this institution are no longer supported! Currently you will be unable to import this membership!" },
      { name: "EXPIRED", message: "The MFA was not answer within the time alloted by your financial institution" },
      { name:  "FAILED", message: "There was a problem validating your credentials with your institution. Please try again later!" },
      { name: "IMPAIRED", message: "You must re-authenticate before your data can be imported. Please re-enter your credentials" },
      { name: "IMPEDED", message: "Your attention is needed at this institutions website! Please log in to the appropriate website for this institution and follow the steps to resolve this issue" },
      { name: "IMPORTED", message: "You must re-authenticate before your data can be imported. Please re-enter your credentials" },
      { name: "LOCKED", message:  "Your account is currently locked! Please log onto your financial institutions website and follow the steps to resolve the issue." },
      { name: "PREVENTED", message:  "The last 3 attempts to access your memebership have failed! Please re-enter your credentials to continue importing your data" },
      { name: "RECONNECTED", message: "You need to re-enter your credentials to reconnect to your institution"},
      { name: "REJECTED", message: "The answer or answers provided were incorrect. Please try again" },
      { name: "RESUMED", message: "Please wait while we finish aggregating your account" },
      { name: "UPDATED", message: "Finishing connecting to your institution"}
    ])