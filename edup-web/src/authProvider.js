import { AUTH_LOGIN, AUTH_LOGOUT, AUTH_ERROR, AUTH_GET_PERMISSIONS } from 'react-admin';
import decodeJwt from 'jwt-decode';

const setItems = (id, email, token) => {
  localStorage.setItem('id', id);
  localStorage.setItem('email', email);
  localStorage.setItem('token', token);

  const decodedToken = decodeJwt(token);
  localStorage.setItem('role', decodedToken.roles);
}

const removeItems = () => {
  localStorage.removeItem('id');
  localStorage.removeItem('email');
  localStorage.removeItem('token');
  localStorage.removeItem('role');
}

export default (type, params) => {
if (type === AUTH_LOGIN) {
        const { username, password } = params;
        const request = new Request('http://localhost:4001/signin', {
            method: 'POST',
            body: JSON.stringify({ email: username, password: password }),
            headers: new Headers({ 'Content-Type': 'application/json' }),
        })
        return fetch(request)
            .then(response => {
                if (response.status < 200 || response.status >= 300) {
                    throw new Error(response.statusText);
                }
                return response.json();
            })
            .then(({ id, email, token }) => {
              setItems(id, email, token);
            });
    }

    if (type === AUTH_LOGOUT) {
        removeItems()
        return Promise.resolve();
    }

    if (type === AUTH_ERROR) {
        const status  = params.status;
        if (status === 401 || status === 403) {
            removeItems()
            return Promise.reject();
        }
        return Promise.resolve();
    }

    if (type === AUTH_GET_PERMISSIONS) {
        const role = localStorage.getItem('role');
        return role ? Promise.resolve(role) : Promise.reject();
    }

    return Promise.resolve();
}
