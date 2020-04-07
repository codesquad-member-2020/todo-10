// export interface IColumn {
//     columns: [],
//     columnTitle: string;
//     content: [];
// }

// const data = {
//     columns:
//         [
//             {
//                 columnTitle: "해야 할 일",
//                 columnId: "100",
//                 cards: [
//                     { cardId: "1", cardContent: "내용1 출력됩니다." },
//                     { cardId: "2", cardContent: "내용2 출력됩니다." },
//                 ]
//             },
//             {
//                 columnTitle: "하고 있는 일",
//                 columnId: "200",
//                 cards: [
//                     { cardId: "3", cardContent: "내용3 출력됩니다." },
//                     { cardId: "4", cardContent: "내용4 출력됩니다." },
//                 ]
//             },
//             {
//                 columnTitle: "완료 된 일",
//                 columnId: "300",
//                 cards: [
//                     { cardId: "5", cardContent: "내용5 출력됩니다." },
//                     { cardId: "6", cardContent: "내용6 출력됩니다." },
//                 ]
//             },
//         ]
// }

const data = {
    "columns": [
        {
            "id": "1",
            "title": "해야 할 일",
            "cards": [
                {
                    "id": "2",
                    "content": "내용2 출력됩니다."
                },
                {
                    "id": "1",
                    "content": "내용1 출력됩니다."
                }
            ]
        },
        {
            "id": "2",
            "title": "하고 있는 일",
            "cards": [
                {
                    "id": "3",
                    "title": "제목1",
                    "content": "내용3 출력됩니다."
                },
                {
                    "id": "4",
                    "title": null,
                    "content": "내용5 출력됩니다."
                },
                {
                    "id": "3",
                    "title": "제목3",
                    "content": "내용6 출력됩니다."
                },
                {
                    "id": "4",
                    "title": null,
                    "content": "내용4 출력됩니다."
                },
                {
                    "id": "3",
                    "title": null,
                    "content": "내용3 출력됩니다."
                }
            ]
        },
        {
            "id": "3",
            "title": "완료 된 일",
            "cards": [
                {
                    "id": "5",
                    "title": "제목9",
                    "content": "내용5 출력됩니다."
                },
                {
                    "id": "6",
                    "title": null,
                    "content": "내용1 출력됩니다."
                }
            ]
        }
    ],
}

export default data;