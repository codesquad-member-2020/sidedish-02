import React, { useState } from 'react';

const Login = ({ }) => {
    const [isLogin, setIsLogin] = useState(false);

    const clickLogin = async () => {
        // const statusCode = await fetchJSON_status("https://github.com/login/oauth/authorize?client_id=5d89cbaa5b442d53d545");
        // (statusCode === '200') && setIsLogin(true);
        setIsLogin(!isLogin);
    }

    return (
        <>
            <button className="dropbtn login" onClick={clickLogin} style={{ display: isLogin ? 'none' : 'block' }}>LOGIN</button>
            <button className="dropbtn login" onClick={clickLogin} style={{ display: isLogin ? 'block' : 'none' }}>LOGOUT</button>
        </>
    )
}

const fetchJSON_status = (url) => {
    return fetch(url)
        .then(response => {
            return response.json().status;
        });
}

export default Login