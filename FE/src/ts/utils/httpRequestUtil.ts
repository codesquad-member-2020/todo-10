import { drawLoading } from '../loginModules/tamplate';
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
                'Authorization': sessionStorage.getItem('TODO-TOKEN')
            }
        };
        document.querySelector('#dimmed').innerHTML = drawLoading();
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
                'Authorization': sessionStorage.getItem('TODO-TOKEN')
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
                'Authorization': sessionStorage.getItem('TODO-TOKEN')
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
                'Authorization': sessionStorage.getItem('TODO-TOKEN')
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
                'Authorization': sessionStorage.getItem('TODO-TOKEN')
            },
        };
        const response = await fetch(url, option);
        const resPromise = await response.json();
        return resPromise;
    },
};

export { httpRequest };
