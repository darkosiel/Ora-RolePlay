---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 02/09/2019 15:01
---

local fathers = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45}
local mothers = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45}

local fatherNames = {
    "Benjamin",
    "Daniel",
    "Joshua",
    "Noah",
    "Andrew",
    "Juan",
    "Alex",
    "Isaac",
    "Evan",
    "Ethan",
    "Vincent",
    "Angel",
    "Diego",
    "Adrian",
    "Gabriel",
    "Michael",
    "Santiago",
    "Kevin",
    "Louis",
    "Samuel",
    "Anthony",
    "Claude",
    "Niko",
    "John",
    "Hannah",
    "Aubrey",
    "Jasmine",
    "Gisele",
    "Amelia",
    "Isabella",
    "Zoe",
    "Ava",
    "Camila",
    "Violet",
    "Sophia",
    "Evelyn",
    "Nicole",
    "Ashley",
    "Gracie",
    "Brianna",
    "Natalie",
    "Olivia",
    "Elizabeth",
    "Charlotte",
    "Emma",
    "Misty"
}
local motherNames = {
    "Benjamin",
    "Daniel",
    "Joshua",
    "Noah",
    "Andrew",
    "Juan",
    "Alex",
    "Isaac",
    "Evan",
    "Ethan",
    "Vincent",
    "Angel",
    "Diego",
    "Adrian",
    "Gabriel",
    "Michael",
    "Santiago",
    "Kevin",
    "Louis",
    "Samuel",
    "Anthony",
    "Claude",
    "Niko",
    "Hannah",
    "Aubrey",
    "Jasmine",
    "Gisele",
    "Amelia",
    "Isabella",
    "Zoe",
    "Ava",
    "Camila",
    "Violet",
    "Sophia",
    "Evelyn",
    "Nicole",
    "Ashley",
    "Gracie",
    "Brianna",
    "Natalie",
    "Olivia",
    "Elizabeth",
    "Charlotte",
    "Emma",
    "Misty"
}

local name = {
    ["Benjamin"] = 0,
    ["Daniel"] = 1,
    ["Joshua"] = 2,
    ["Noah"] = 3,
    ["Andrew"] = 4,
    ["Juan"] = 5,
    ["Alex"] = 6,
    ["Isaac"] = 7,
    ["Evan"] = 8,
    ["Ethan"] = 9,
    ["Vincent"] = 10,
    ["Angel"] = 11,
    ["Diego"] = 12,
    ["Adrian"] = 13,
    ["Gabriel"] = 14,
    ["Michael"] = 15,
    ["Santiago"] = 16,
    ["Kevin"] = 17,
    ["Louis"] = 18,
    ["Samuel"] = 19,
    ["Anthony"] = 20,
    ["Hannah"] = 21,
    ["Aubrey"] = 22,
    ["Jasmine"] = 23,
    ["Gisele"] = 24,
    ["Amelia"] = 25,
    ["Isabella"] = 26,
    ["Zoe"] = 27,
    ["Ava"] = 28,
    ["Camila"] = 29,
    ["Violet"] = 30,
    ["Sophia"] = 31,
    ["Evelyn"] = 32,
    ["Nicole"] = 33,
    ["Ashley"] = 34,
    ["Gracie"] = 35,
    ["Brianna"] = 36,
    ["Natalie"] = 37,
    ["Olivia"] = 38,
    ["Elizabeth"] = 39,
    ["Charlotte"] = 40,
    ["Emma"] = 41,
    ["Claude"] = 42,
    ["Niko"] = 43,
    ["John"] = 44,
    ["Misty"] = 45
}
function CreatorMenuHeritage(indexCharacter, createPlayer)
    RageUI.DrawContent(
        {header = true, instructionalButton = true},
        function()
            createPlayer[createPlayer.Model].Face.face.face = nil
            --      RageUI.HeritageWindow(name[motherNames[indexCharacter[createPlayer.Model].Face.face.mom]], name[fatherNames[indexCharacter[createPlayer.Model].Face.face.dad]])
            RageUI.HeritageWindow(
                indexCharacter[createPlayer.Model].Face.face.mom,
                indexCharacter[createPlayer.Model].Face.face.dad
            )
            RageUI.List(
                "Mère",
                motherNames,
                indexCharacter[createPlayer.Model].Face.face.mom,
                GetLabelText("CHARC_H_30"),
                {},
                true,
                function(Hovered, Active, Selected, Index)
                    if createPlayer[createPlayer.Model].Face.face.mom ~= Index then
                        createPlayer[createPlayer.Model].Face.face.mom = mothers[Index]
                        indexCharacter[createPlayer.Model].Face.face.mom = Index
                    end
                end
            )
            RageUI.List(
                "Père",
                fatherNames,
                indexCharacter[createPlayer.Model].Face.face.dad,
                GetLabelText("CHARC_H_31"),
                {},
                true,
                function(Hovered, Active, Selected, Index)
                    if createPlayer[createPlayer.Model].Face.face.dad ~= Index then
                        createPlayer[createPlayer.Model].Face.face.dad = fathers[Index]
                        indexCharacter[createPlayer.Model].Face.face.dad = Index
                    end
                end
            )
            RageUI.UISliderHeritage(
                GetLabelText("FACE_H_DOM"),
                math.round(indexCharacter[createPlayer.Model].Face.resemblance, 2) * 10,
                GetLabelText("CHARC_H_9"),
                function(Hovered, Selected, Active, Heritage, Index)
                    if createPlayer[createPlayer.Model].Face.resemblance ~= Heritage then
                        createPlayer[createPlayer.Model].Face.resemblance = Heritage
                        indexCharacter[createPlayer.Model].Face.resemblance = Heritage
                    end
                end
            )
            RageUI.UISliderHeritage(
                GetLabelText("FACE_H_STON"),
                math.round(indexCharacter[createPlayer.Model].Face.skinMix, 2) * 10,
                GetLabelText("FACE_HER_ST_H"),
                function(Hovered, Selected, Active, Heritage, Index)
                    if createPlayer[createPlayer.Model].Face.skinMix ~= Heritage then
                        createPlayer[createPlayer.Model].Face.skinMix = Heritage
                        indexCharacter[createPlayer.Model].Face.skinMix = Heritage
                    end
                end
            )
            UpdateEntityFace(PlayerPedId(), createPlayer[createPlayer.Model].Face)
        end,
        function()
            ---Panels
        end
    )
end
