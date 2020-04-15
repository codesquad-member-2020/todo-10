const httpRequest = {
    async login(url: string) {
        const option = {
            method: 'POST',
            mode: 'cors',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                email: "nigayo@ggmail.com",
                password: "1234"
            })
        };
        const response = await fetch(url, option);
        const resPromise = await response.json();
        return resPromise;
    },

    async post(url: string, data: object) {
        const option = {
            method: 'POST',
            mode: 'cors',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data),
        };
        const response = await fetch(url, option);
        const resPromise = await response.json();
        return resPromise;
    },

    async delete(url: string) {
        const option = {
            mode: 'cors',
            method: 'DELETE',
        };
        const response = await fetch(url, option);
        const resPromise = await response.json();
        return resPromise;
    },

    async patch(url: string, data: object) {
        const option = {
            method: 'PATCH',
            mode: 'cors',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data),
        };
        const response = await fetch(url, option);
        const resPromise = await response.json();
        return resPromise;
    },
};

export { httpRequest };
