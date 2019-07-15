import React, { useState, useEffect, Fragment } from "react";
// import axios from "axios";

const API_URL =
  "https://1gr9avh006.execute-api.us-east-2.amazonaws.com/prod/root";

export default () => {
  const [response, setresponse] = useState("Not yet...");
  useEffect(() => {
    async function fetchData() {
      const apiRes = await fetch(API_URL);
      const data = await apiRes.json();
      return data;
    }
    fetchData().then(res => {
      // console.log("RES", res);
      setresponse(res);
    });
    // setresponse(data);
    // console.log("FETCHED: ", data);
  }, []);
  return <Fragment>{response}</Fragment>;
};
