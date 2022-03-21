import { useEffect,useState } from "react";
import Grid from "@mui/material/Grid";
import React from 'react';
import { useParams } from "react-router-dom";

// Material Kit 2 React components
import MKBox from "components/MKBox";
import MKInput from "components/MKInput";
import MKButton from "components/MKButton";
import MKTypography from "components/MKTypography";

import { getFirestore,doc,getDoc ,setDoc,updateDoc, arrayUnion, arrayRemove } from "firebase/firestore"
import { useUserAuth } from "../../../UserAuthContext";


import Popup from 'reactjs-popup';
import 'reactjs-popup/dist/index.css';
import './modal.css'

import DataTable from 'react-data-table-component';

import Countdown from 'react-countdown';

function BidsPage()  {
  const params = useParams();
  const {user} = useUserAuth();
  const [bidprice, setBidPrice] = useState(0);
  const [error, setError] = useState("");
  const [userRequest, setUserRequest] = useState({
    isLoading: false,
    timer: false,
    bidExists:false,
    data:[],
    bgImage:"",
  });


  const columns = [
    {
        name: 'User',
        selector: row => row.bid_username,
    },
    {
        name: 'Price($)',
        selector: row => row.bid_price,
        sortable: true,

    },
  ];

  const Completionist = () => {
    let h_bid
    let h_user
    Math.max.apply(Math, userRequest.data.map(function(o) {
      h_bid = o.bid_price; 
      h_user = o.bid_username
    }))
    console.log(h_bid)
    console.log(h_user)
    return(
      <span>ok</span>
    )
  }


  const renderer = ({ minutes, seconds, completed }) => {
    if (completed) {
      // Render a completed state
      return <Completionist />;
    } else {
      // Render a countdown
      return <span>{minutes}:{seconds}</span>;
    }
  };
  
  useEffect(async() =>{
    const db = getFirestore();
    const docRef = doc(db, "Cards", params.id);
    const docSnap = await getDoc(docRef);
    
    let arr = []
    let arr2 = []
    let loading
    let timer
    let image
    if (docSnap.exists()) {
    image= docSnap.data().images.large
    loading = false
    timer = true
    } else {
    console.log("No such document!");
    }

    const docRef2 = doc(db, "Bids", "bid_"+params.id);
    const docSnap2 = await getDoc(docRef2);

    if (docSnap2.exists()) {
    arr = docSnap2.data().user_price;
    arr.map((item) =>{
      arr2.push({id:item.uid,bid_username:item.user_email,bid_price:item.price})
    })
    setUserRequest({
      isLoading: loading,
      timer: timer,
      bidExists:true,
      data:arr2,
      bgImage:image
    });
    } else {
    console.log("No such document!");
    }


  },[])


  const handleBid = async (e) => {
    e.preventDefault();
    setError("");
    const db = getFirestore();
    if(!userRequest.bidExists){
      try {
        // Add a new document in collection "cities"
        await setDoc(doc(db, "Bids","bid_"+params.id), {
          card_id: params.id,
          user_price: [{user_uid:user.uid,user_email:user.email,price:bidprice}],
          status: true,
          duration: 24,
        },{ capital: true }, { merge: true });
        setUserRequest({
          isLoading: true,
          timer: true,
        });
      } catch (err) {
        setError(err.message);
      }
    }
    
    else{
      try {
        //get doc
        const docRef = doc(db, "Bids", "bid_"+params.id);
        // Atomically add a new region to the "regions" array field.
        await updateDoc(docRef, {
          user_price: arrayUnion({user_uid:user.uid,user_email:user.email,price:bidprice})
        });
      } catch (err) {
        setError(err.message);
      }
    }
  };

  if(!userRequest.isLoading){
    return (
     
        <Grid container spacing={0.5} alignItems="center">
          <Grid item xs={12} lg={6}>
            <MKBox
              display={{ xs: "none", lg: "flex" }}
              width="calc(100% - 3rem)"
              height="calc(100vh - 7rem)"
              borderRadius="lg"

              sx={{ backgroundImage: `url(${userRequest.bgImage})`,backgroundRepeat: 'no-repeat', 
              backgroundPosition: 'center'}}
            />
          </Grid>
          <Grid
            item
            xs={12}
            sm={10}
            md={7}
            lg={6}
            xl={4}
            ml={{ xs: "auto", lg: 6 }}
            mr={{ xs: "auto", lg: 6 }}
          >
            <MKBox
              bgColor="white"
              borderRadius="xxl"
              shadow="lg"
              display="flex"
              flexDirection="column"
              justifyContent="center"
              mt={{ xs: 20, sm: 18, md: 20 }}
              mb={{ xs: 20, sm: 18, md: 20 }}
              mx={0.001}
              > 
              <MKBox
                variant="gradient"
                bgColor="info"
                coloredShadow="info"
                borderRadius="lg"
                p={2}
                mx={2}
                mt={-3}
              >
                <MKTypography variant="h3" color="white">
                  Bids
                </MKTypography>
                <div>
                {userRequest.timer
                    ? <div>
                      <Countdown
                          date={Date.now() + 5000}
                          renderer={renderer}
                        />
                    </div>
                    : <div>No Data</div>
                  }
                </div>
              </MKBox>
              <MKBox p={3}>
                <div>
                {userRequest.bidExists
                    ? <DataTable
                    columns={columns}
                    data={userRequest.data}
                    defaultSortFieldId={1}
                />
                    : <div>No Data</div>
                  }
                </div>
                <MKBox width="100%" component="form" method="post" autocomplete="off">
                  <Grid container item justifyContent="center" xs={12} mt={5} mb={2}>
                    <Popup
                      trigger={<MKButton variant="gradient" color="info">
                      Place Bid
                    </MKButton>}
                      modal
                      nested
                    >
                      {close => (
                        <div className="modal">
                          <button className="close" onClick={close}>
                            &times;
                          </button>
                          <div className="header"> Place Bid</div>
                          <div className="content">
                          <MKBox component="form" role="form" onSubmit={handleBid}>
                          <MKBox mb={3}>
                            <MKInput name="bidprice" type="price" label="Price" fullWidth onChange={(e) => setBidPrice(e.target.value)}/>
                          </MKBox>
                          <MKBox mt={4} mb={1}>
                            <MKButton variant="gradient" color="info" type="submit" fullWidth>
                              Place bid
                            </MKButton>
                          </MKBox>
                        </MKBox>
                          </div>
                        </div>
                      )}
                    </Popup>
                  </Grid>
                </MKBox>
              </MKBox>
            </MKBox>
          </Grid>
        </Grid>
    );
}
else{
  return(
    <div>
    </div>
  )
}
}


export default BidsPage;