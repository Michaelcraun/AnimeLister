//
//  TESTDATA.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/19/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

// MARK: - Users
let currentUser = User(
    id: 0,
    firstName: "Michael",
    lastName: "Craun",
    username: "kurai_itaki",
    email: "michael.craun@gmail.com",
    photo: "",
    anime: [],
    manga: [],
    __meta__: UserMeta(likedPosts: []),
    friends: [deborahCraun])

let deborahCraun = User(
    id: 1,
    firstName: "Deborah",
    lastName: "Craun",
    username: "didarbig01",
    email: "deborah.darbig@gmail.com",
    photo: "",
    anime: [],
    manga: [],
    __meta__: UserMeta(likedPosts: []),
    friends: [])

let brettChapin = User(
    id: 2,
    firstName: "Brett",
    lastName: "Chapin",
    username: "blackroseangel",
    email: "blackroseangel@gmail.com",
    photo: "",
    anime: [],
    manga: [],
    __meta__: UserMeta(likedPosts: []),
    friends: [])

let thomasBunn = User(
    id: 3,
    firstName: "Thomas",
    lastName: "Bunn",
    username: "tbunn00",
    email: "thomas.bunn00@gmail.com",
    photo: "",
    anime: [],
    manga: [],
    __meta__: UserMeta(likedPosts: []),
    friends: [])

// MARK: - Posts
let post0 = Post(
    id: 0,
    photo: "dbz",
    text: "I just finsihed episode 132 of DragonBall Z! Only 159 more episodes to go! I love shonen anime!",
    source: nil,
    link: nil,
    __meta__: PostMeta(
        likes: 12,
        shares: 1),
    user: currentUser,
    createdAt: "2019-06-18 21:03:45.074909-0400")

let post1 = Post(
    id: 0,
    photo: "",
    text: "I just wanna go home, sit on my couch, and watch anime...",
    source: nil,
    link: nil,
    __meta__: PostMeta(
        likes: 1,
        shares: 0),
    user: currentUser,
    createdAt: "2019-06-18 20:59:22.693776-0400")

let post2 = Post(
    id: 0,
    photo: "",
    text: "Watching some Dragonball Z. ",
    source: nil,
    link: nil,
    __meta__: PostMeta(
        likes: 243,
        shares: 47),
    user: currentUser,
    createdAt: "2019-06-18 14:24:14.455616-0400")
