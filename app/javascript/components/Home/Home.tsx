import * as React from "react";
import { useState, useEffect } from 'react';
import Box from '@mui/material/Box';
import Container from '@mui/material/Container';
import Typography from "@mui/material/Typography";
import IconButton from '@mui/material/IconButton';
import { ArticleBlock } from './styles';

export type ArticlesDataType = {
  created_at: string;
  current: boolean;
  description: string;
  expiry: string;
  external_id: string;
  id: number;
  liked: boolean;
  section: string;
  title: string;
  updated_at: string;
}[];

export default function Home() {
  const [data, setData] = useState<ArticlesDataType | undefined>(undefined);
  const [isLoading, setLoading] = useState(false);

  useEffect(() => {
    setLoading(true);
    fetch('api/v1/articles')
      .then((res) => res.json())
      .then((data) => {
        setData(data);
        setLoading(false);
      });
  }, []);

  return (
    <Container maxWidth="lg">
      {data?.map((dataPoint) => (
            <ArticleBlock >
              <Typography variant="h5">
                  {dataPoint.title}
              </Typography>
              <Typography variant="body1">
                  {`Description: ${dataPoint.description}`}
              </Typography>
              <Typography variant="body1">
                  {`Expiry: ${dataPoint.expiry.substring(0, 10)}`}
              </Typography>
            </ArticleBlock>
      ))}          
    </Container>
  );
}