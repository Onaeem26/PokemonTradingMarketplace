import { useState } from "react";

// react-router-dom components
import {  useNavigate } from "react-router-dom";

// @mui material components
import Card from "@mui/material/Card";
import Grid from "@mui/material/Grid";


// Material Kit 2 React components
import MKBox from "components/MKBox";
import MKTypography from "components/MKTypography";
import MKInput from "components/MKInput";
import MKButton from "components/MKButton";
import { useUserAuth } from "../../../UserAuthContext";

import { getFirestore,collection, addDoc } from "firebase/firestore"

function SignUp() {
  const [email, setEmail] = useState("");
  const [error, setError] = useState("");
  const [password, setPassword] = useState("");
  const [name, setName] = useState("");
  const [phone, setPhone] = useState("");
  const { signUp } = useUserAuth();
  let navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    const db = getFirestore();
    try {
      const res = await signUp(email, password);
      const user = res.user;
      await addDoc(collection(db, "Users"), {
      uid: user.uid,
      email,
      name:name,
      phone:phone
      });
      navigate("/");
    } catch (err) {
      setError(err.message);
    }
  };


  return (
    <>
      <MKBox px={1} width="100%" height="100vh" mx="auto" position="relative" zIndex={2}>
        <Grid container spacing={1} justifyContent="center" alignItems="center" height="100%">
          <Grid item xs={11} sm={9} md={5} lg={4} xl={3}>
            <Card>
              <MKBox
                variant="gradient"
                bgColor="info"
                borderRadius="lg"
                coloredShadow="info"
                mx={2}
                mt={-3}
                p={2}
                mb={1}
                textAlign="center"
              >
                <MKTypography variant="h4" fontWeight="medium" color="white" mt={1}>
                  Sign Up
                </MKTypography>
              </MKBox>
              <MKBox pt={4} pb={3} px={3}>
                <MKBox component="form" role="form" onSubmit={handleSubmit}>
                  <MKBox mb={2}>
                  <MKBox mb={2}>
                    <MKInput name="name" type="name" label="Full Name" fullWidth onChange={(e) => setName(e.target.value)} />
                  </MKBox>
                    <MKInput name="email" type="email" label="Email" fullWidth onChange={(e) => setEmail(e.target.value)} />
                  </MKBox>
                  <MKBox mb={2}>
                  <MKBox mb={2}>
                    <MKInput name="phone" type="name" label="phone" fullWidth onChange={(e) => setPhone(e.target.value)} />
                  </MKBox>
                    <MKInput name="password" type="password" label="Password" fullWidth onChange={(e) => setPassword(e.target.value)} />
                  </MKBox>
                  <MKBox display="flex" alignItems="center" ml={-1}>
                  </MKBox>
                  <MKBox mt={4} mb={1}>
                    <MKButton variant="gradient" color="info" type="submit" fullWidth>
                      Sign up
                    </MKButton>
                    <div>{error}</div>
                  </MKBox>
                  <MKBox mt={3} mb={1} textAlign="center">
                  </MKBox>
                </MKBox>
              </MKBox>
            </Card>
          </Grid>
        </Grid>
      </MKBox>
    </>
  );
}

export default SignUp;
