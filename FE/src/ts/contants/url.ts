const BASE_DEV_URL = 'http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080';

const URL = {
    DEV: {
        LOGIN_API: () => `${BASE_DEV_URL}/mock/login`,
        BOARD_API: () => `${BASE_DEV_URL}/board`,
        ADD_CARD_API: (sectionId) => `${BASE_DEV_URL}/mock/section/${sectionId}/card`,
        UPDATE_CARD_API: (sectionId, cardId) => `${BASE_DEV_URL}/mock/section/${sectionId}/card/${cardId}`,
        LOGS_API: () => `${BASE_DEV_URL}/board/logs`,
    },
}

export { URL };