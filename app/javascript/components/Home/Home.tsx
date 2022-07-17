import * as React from "react";
import { useState, useEffect } from 'react';
import Container from '@mui/material/Container';
import Typography from "@mui/material/Typography";
import IconButton from '@mui/material/IconButton';
import FavoriteBorderIcon from '@mui/icons-material/FavoriteBorder';
import FavoriteIcon from '@mui/icons-material/Favorite';
import CircularProgress from '@mui/material/CircularProgress';
import Box from '@mui/material/Box';
import { ArticleBlock, ArticleTextBlock } from './styles';

export type ArticlesDataType = {
  created_at: string;
  current: boolean;
  description: string;
  expiry: string;
  external_id: number;
  id: string;
  liked: boolean;
  section: string;
  title: string;
  updated_at: string;
}[];

export default function Home() {
  const [data, setData] = useState<ArticlesDataType | undefined>(undefined);
  const [isLoading, setLoading] = useState(false);

  const loadingSpinner = <Box sx={{ display: 'flex', justifyContent: 'center' }}>
    <CircularProgress />
  </Box>

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const response = await fetch('api/v1/articles');
        if (!response.ok) throw Error(response.statusText);
        const data = await response.json();
        setData(data);
      } catch (error) {
        console.error(error);
      }
      setLoading(false);      
    }
    fetchData();
  }, []);

  const onLikeButtonClick = (id: string) => {
    const article = data.find((dataPoint) => dataPoint.id === id);
    const updatedArticle = { ...article, liked: !article.liked };
    const index = data.indexOf(article);
    const updatedData = [...data];
    updatedData.splice(index, 1, updatedArticle);
    setData(updatedData);
    updateArticle(article.id, !article.liked);
  }

  const updateArticle = async (id: string, liked: boolean) => {
    try {
      const response = await fetch(
        `/api/v1/articles/${id}`,
        {
          method: 'PUT',
          body: JSON.stringify({
            article: {
              id: id,
              liked: liked
            }
          }),
          headers: {
            'Content-Type': 'application/json'
          }
        }
      );
      if (!response.ok) throw Error(response.statusText);
    } catch (error) {
      console.error(error);
    }
  }

  return (
    <Container maxWidth="lg">
      {
        isLoading ? loadingSpinner : data?.map((dataPoint) => (
            <ArticleBlock key={dataPoint.id}>
                <ArticleTextBlock >
                  <Typography variant="h5" sx={{color: "#009187"}}>
                    { dataPoint.title }
                  </Typography>
                  <Typography variant="body1" sx={{color: "#009187"}}>
                      { `Description: ${dataPoint.description}` }
                  </Typography>
                  <Typography variant="body1" sx={{color: "#009187"}}>
                      { `Expiry: ${dataPoint.expiry.substring(0, 10)}` }
                  </Typography>
                </ArticleTextBlock> 
                <IconButton sx={{color: "#910000"}} onClick={() => onLikeButtonClick(dataPoint.id)}>
                  { dataPoint.liked ? <FavoriteIcon /> : <FavoriteBorderIcon /> }
                </IconButton>
            </ArticleBlock>
      ))}          
    </Container>
  );
}