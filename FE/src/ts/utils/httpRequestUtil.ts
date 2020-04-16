const token = sessionStorage.getItem('TODO-TOKEN');

const httpRequest = {
    async login(url: string, data: object) {
        const option = {
            method: 'POST',
            mode: 'cors',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        };
        const response = await fetch(url, option);
        const headers = [...response.headers];
        headers.forEach(([header, value]) => {
            if (header === 'authorization') sessionStorage.setItem('TODO-TOKEN', value);
        });
        const resPromise = await response.json();
        return resPromise;
    },

    async get(url: string) {
        const option = {
            method: 'GET',
            mode: 'cors',
            headers: {
                'Authorization': token
            }
        };
        const response = await fetch(url, option);
        const resPromise = await response.json();
        return resPromise;
    },

    async post(url: string, data: object) {
        const option = {
            method: 'POST',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': token
            },
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
            headers: {
                'Authorization': token
            }
        };
        const response = await fetch(url, option);
        const resPromise = await response.json();
        return resPromise;
    },

    async patch(url: string, data: object) {
        const option = {
            method: 'PATCH',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': token
            },
            body: JSON.stringify(data),
        };
        const response = await fetch(url, option);
        const resPromise = await response.json();
        return resPromise;
    },

    async put(url: string) {
        const option = {
            method: 'PUT',
            mode: 'cors',
            headers: {
                'Authorization': token
            },
        };
        const response = await fetch(url, option);
        const resPromise = await response.json();
        return resPromise;
    },
};

export { httpRequest };
